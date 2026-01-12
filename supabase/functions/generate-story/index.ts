import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { GoogleGenerativeAI } from "npm:@google/generative-ai";
import { createClient } from "npm:@supabase/supabase-js@2";

// CORS headers for cross-origin requests
const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

/**
 * Story Generator Edge Function
 * 
 * Generates stories based on Indian scriptures using Gemini AI
 * and stores them in Supabase database
 */

// Types matching Flutter entities
interface StoryPrompt {
  scripture?: string;
  scriptureSubtype?: string;
  storyType?: string;
  theme?: string;
  mainCharacter?: string;
  setting?: string;
  rawPrompt?: string;
  isRawPrompt?: boolean;
}

interface GeneratorOptions {
  language: {
    displayName: string;
    code: string;
  };
  format: {
    displayName: string;
    description: string;
  };
  length: {
    displayName: string;
    description: string;
    approximateWords: number;
  };
}

interface StoryRequest {
  prompt: StoryPrompt;
  options: GeneratorOptions;
  userId?: string;
}

interface StoryAttributes {
  storyType: string;
  theme: string;
  mainCharacterType: string;
  storySetting: string;
  timeEra: string;
  narrativePerspective: string;
  languageStyle: string;
  emotionalTone: string;
  narrativeStyle: string;
  plotStructure: string;
  storyLength: string;
  references: string[];
  tags: string[];
  characters: string[];
}

interface StoryResponse {
  id: string;
  title: string;
  scripture: string;
  story: string;
  quotes: string;
  trivia: string;
  activity: string;
  lesson: string;
  attributes: StoryAttributes;
  imageUrl?: string;
  author?: string;
  publishedAt?: string;
  createdAt: string;
  likes: number;
  views: number;
  isFavorite: boolean;
  authorId?: string;
  commentCount: number;
  shareCount: number;
  isLikedByCurrentUser: boolean;
}

/**
 * Builds a comprehensive system prompt for story generation
 */
function buildSystemPrompt(prompt: StoryPrompt, options: GeneratorOptions): string {
  const scripture = prompt.scripture || "Indian scriptures";
  const wordCount = options.length.approximateWords;
  const language = options.language.displayName;
  const narrativeStyle = options.format.displayName;

  return `You are an expert storyteller and scholar of Indian scriptures including the Ramayana, Mahabharata, Vedas, Puranas, and other sacred texts. Your task is to generate an engaging, educational, and authentic story.

**Story Requirements:**
- Scripture Source: ${scripture}
- Story Type: ${prompt.storyType || "Any appropriate type"}
- Theme: ${prompt.theme || "Moral and ethical teachings"}
- Main Character: ${prompt.mainCharacter || "Characters from the scripture"}
- Setting: ${prompt.setting || "Traditional setting from the scripture"}
- Language: ${language}
- Narrative Style: ${narrativeStyle} (${options.format.description})
- Length: Approximately ${wordCount} words (${options.length.displayName})

**Output Format (CRITICAL - MUST FOLLOW EXACTLY):**
You must respond ONLY with a valid JSON object. Do not include any markdown code blocks, backticks, or additional text. The JSON must have this exact structure:

{
  "title": "Engaging title for the story",
  "story": "The complete story text formatted in markdown. Use headings (##), paragraphs, **bold** for emphasis, *italics* for character thoughts, and > blockquotes for important dialogues or verses. Make it visually appealing and easy to read.",
  "quotes": "2-3 relevant quotes or verses from the scripture in markdown format, each on a new line with > blockquote formatting",
  "trivia": "3-5 interesting facts about the story, characters, or historical context in markdown with bullet points",
  "activity": "A practical activity or exercise readers can do to connect with the story's teachings (in markdown)",
  "lesson": "The moral or philosophical lesson from the story, explained clearly in markdown",
  "attributes": {
    "storyType": "${prompt.storyType || "Mythological Tale"}",
    "theme": "${prompt.theme || "Dharma and Righteousness"}",
    "mainCharacterType": "${prompt.mainCharacter || "Divine Being"}",
    "storySetting": "${prompt.setting || "Ancient India"}",
    "timeEra": "The historical or mythological era (e.g., Treta Yuga, Dwapara Yuga)",
    "narrativePerspective": "The narrative perspective used (e.g., Third Person, First Person)",
    "languageStyle": "${language}",
    "emotionalTone": "The primary emotional tone (e.g., Inspirational, Reflective, Heroic)",
    "narrativeStyle": "${narrativeStyle}",
    "plotStructure": "The story structure used (e.g., Hero's Journey, Moral Lesson, Battle Epic)",
    "storyLength": "${options.length.displayName}",
    "references": ["List of scripture references used"],
    "tags": ["relevant", "tags", "for", "categorization"],
    "characters": ["Main characters in the story"]
  }
}

**Story Content Guidelines:**
1. **Authenticity**: Base the story on authentic scripture sources
2. **Engagement**: Make it captivating and emotionally resonant
3. **Education**: Include historical and cultural context
4. **Accessibility**: Write for modern readers while respecting tradition
5. **Markdown Formatting**: Use proper markdown for structure and readability
   - Use ## for section headings
   - Use **bold** for important terms
   - Use *italics* for emphasis or thoughts
   - Use > blockquotes for verses or important dialogues
   - Use bullet points for lists
   - Add line breaks for better readability

**Remember:**
- Output ONLY the JSON object, no other text
- All text fields should use markdown formatting
- Be culturally sensitive and respectful
- Ensure accuracy in scriptural references
- Make the story appropriate for all ages`;
}

/**
 * Parses Gemini response and extracts JSON
 */
function parseGeminiResponse(responseText: string): any {
  try {
    // Remove markdown code blocks if present
    let cleaned = responseText.trim();
    
    // Remove ```json and ``` if present
    if (cleaned.startsWith("```json")) {
      cleaned = cleaned.substring(7);
    } else if (cleaned.startsWith("```")) {
      cleaned = cleaned.substring(3);
    }
    
    if (cleaned.endsWith("```")) {
      cleaned = cleaned.substring(0, cleaned.length - 3);
    }
    
    cleaned = cleaned.trim();
    
    // Parse JSON
    return JSON.parse(cleaned);
  } catch (error: unknown) {
    console.error("Failed to parse Gemini response:", error);
    const errorMessage = error instanceof Error ? error.message : String(error);
    throw new Error(`Invalid JSON response from Gemini: ${errorMessage}`);
  }
}

/**
 * Generates story using Gemini API
 */
async function generateStoryWithGemini(
  prompt: StoryPrompt,
  options: GeneratorOptions,
  apiKey: string
): Promise<any> {
  // Initialize GoogleGenerativeAI with API key
  const genAI = new GoogleGenerativeAI(apiKey);
  const model = genAI.getGenerativeModel({ model: "gemini-3-flash-preview" });
  
  const systemPrompt = buildSystemPrompt(prompt, options);
  
  // Build user prompt based on input
  let userPrompt: string;
  if (prompt.isRawPrompt && prompt.rawPrompt) {
    userPrompt = prompt.rawPrompt;
  } else {
    const parts = [];
    parts.push(`Generate a story from ${prompt.scripture || "Indian scriptures"}`);
    if (prompt.storyType) parts.push(`Story Type: ${prompt.storyType}`);
    if (prompt.theme) parts.push(`Theme: ${prompt.theme}`);
    if (prompt.mainCharacter) parts.push(`Main Character: ${prompt.mainCharacter}`);
    if (prompt.setting) parts.push(`Setting: ${prompt.setting}`);
    userPrompt = parts.join(". ");
  }

  try {
    const fullPrompt = systemPrompt + "\n\nUser Request: " + userPrompt;
    
    // Use generateContent with config
    const result = await model.generateContent({
      contents: [{ role: "user", parts: [{ text: fullPrompt }] }],
      generationConfig: {
        temperature: 0.8,
        topP: 0.95,
        topK: 40,
        maxOutputTokens: 8192,
      },
    });

    const response = await result.response;
    const text = response.text();

    if (!text) {
      throw new Error("No response from Gemini API");
    }

    return parseGeminiResponse(text);
  } catch (error: unknown) {
    console.error("Gemini API Error:", error);
    const errorMessage = error instanceof Error ? error.message : String(error);
    throw new Error(`Failed to generate story: ${errorMessage}`);
  }
}

/**
 * Stores story in Supabase database
 */
async function storeStory(
  storyData: any,
  supabaseUrl: string,
  supabaseKey: string,
  language: string,
  authHeader?: string,
  userId?: string
): Promise<string> {
  // Create Supabase client with proper Auth context
  const supabaseClient = createClient(
    supabaseUrl,
    supabaseKey,
    authHeader
      ? {
          global: {
            headers: { Authorization: authHeader },
          },
        }
      : undefined
  );

  if (!userId) {
    throw new Error("User ID is required to store story");
  }

  const storyRecord = {
    title: storyData.title,
    content: storyData.story, // Mapped to 'content' column
    user_id: userId, // Required NOT NULL column
    language: language,
    metadata: {
      scripture: storyData.attributes.references?.[0] || "Unknown",
      quotes: storyData.quotes,
      trivia: storyData.trivia,
      activity: storyData.activity,
      lesson: storyData.lesson,
    },
    attributes: storyData.attributes,
    published_at: new Date().toISOString(), // Automatically published for now, or null if draft
    created_at: new Date().toISOString(),
    likes: 0,
    views: 0,
    comment_count: 0,
    share_count: 0,
    author_id: userId, // Keeping for backward compatibility if needed, though user_id is primary
  };

  const { data, error } = await supabaseClient
    .from("stories")
    .insert([storyRecord])
    .select()
    .single();

  if (error) {
    console.error("Database Error:", error);
    throw new Error(`Failed to store story: ${error.message}`);
  }

  return data.id;
}

/**
 * Main handler function
 */
Deno.serve(async (req: Request) => {
  // Handle CORS preflight requests
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: corsHeaders });
  }

  try {
    // Get environment variables
    const geminiApiKey = Deno.env.get("GEMINI_API_KEY");
    if (!geminiApiKey) {
      throw new Error("GEMINI_API_KEY environment variable is not set");
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const supabaseKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
    
    if (!supabaseUrl || !supabaseKey) {
      throw new Error("Supabase environment variables are not set");
    }

    // Parse request body
    const requestBody: StoryRequest = await req.json();
    const { prompt, options, userId } = requestBody;

    if (!prompt || !options) {
      return new Response(
        JSON.stringify({ error: "Missing required fields: prompt and options" }),
        {
          status: 400,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    // Generate story using Gemini
    console.log("Generating story with Gemini...");
    const storyData = await generateStoryWithGemini(prompt, options, geminiApiKey);

    // Get auth header for RLS context
    const authHeader = req.headers.get("Authorization") || undefined;

    // Store story in database
    console.log("Storing story in database...");
    const storyId = await storeStory(
      storyData,
      supabaseUrl,
      supabaseKey,
      options.language.displayName,
      authHeader,
      userId
    );

    // Prepare response
    const response: StoryResponse = {
      id: storyId,
      title: storyData.title,
      scripture: storyData.attributes.references?.[0] || prompt.scripture || "Unknown",
      story: storyData.story,
      quotes: storyData.quotes,
      trivia: storyData.trivia,
      activity: storyData.activity,
      lesson: storyData.lesson,
      attributes: storyData.attributes,
      author: "AI Generated",
      publishedAt: new Date().toISOString(),
      createdAt: new Date().toISOString(),
      likes: 0,
      views: 0,
      isFavorite: false,
      authorId: userId,
      commentCount: 0,
      shareCount: 0,
      isLikedByCurrentUser: false,
    };

    return new Response(JSON.stringify(response), {
      status: 200,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (error: unknown) {
    console.error("Error in generate-story function:", error);
    const errorMessage = error instanceof Error ? error.message : "Internal server error";
    const errorDetails = error instanceof Error ? error.toString() : String(error);
    return new Response(
      JSON.stringify({
        error: errorMessage,
        details: errorDetails,
      }),
      {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  }
});
