# Travel AI Agent

> Status: :pencil: Planning

## Index :bookmark_tabs:

:cd: [Description](#description-clipboard) 

:cd: [Architecture](#architecture-gear)    

:cd: [Use Case](#use-case-office) 

:cd: [Technologies](#technologies-books)

:cd: [Contribute](#contribute-gift) 


## Description :clipboard:

<p style="text-align:justify">
The Travel AI Agent is a chatbot system designed to help people in the <b>Destination Discovery Process</b>, gathering client's specific needs and desires through human-friendly conversation and suggesting the best destinations matching the client's requirements.
</p>

## Architecture :gear:

![Architecture Diagram][architecture-jpg]

> *[Download Architecture Diagram (PDF)][architecture-pdf]*

### Services and Modules

1. **Destination Discovery Process Module**
    1. **Goal:** Maintain an updated database of destinations and tourist attractions in order to match their attributes with travelers preferencies and then provide a collection of place suggestions
    2. **Destinations Module**
        - **Services:** Suggest destinations; Manage destinations
    3. **Tourist Attractions Module**
        - **Services:** Suggest tourist attractions; Manage tourist attractions
    4. **Itinerary Module**
        - **Services:** Build itinerary
        - **Functionality:** Production of markdown-based itinerary plans using tourist attractions approved by travelers
2. **Chat Management Module**
    - **Goal:** Manage human-machine interface interactions to improve communication, trigger system routines and maintain messages storage.
    - **Components:**
        - **Live Chat Module**
            - **Services:** Manage chat history
            - **Goal:** Intermediate communications between IBM Watson and User Interface, changing messages format in order to improve comprehension and trigger system routines
        - **Chat History** **Module**
            - **Services:** Control message exchange
            - **Goal:** Maintain a up-to-date history of all messages exchanged between a logged traveler and the chatbot agent

## User Domains

The project is divided into two user domains:

- **Travel**
    - **User:** Travelers - people seeking their next travel destination;
    - **Functionality:** Talk to the chatbot agent, providing travel requirements, needs and desires in order to receive customized suggestion on destinations and tourist attractions.
- **Management**
    - **User:** Travel Agencies;
    - **Functionality:** Submit and maintain destination and tourist attractions information, which will be used by the chatbot agent during conversation with potential clients.

## Use Case :office:

As the adoption of AI-powered systems is increasing rapidly, the demand for applications that can provide personalized services is also growing. The Travel AI Agent is a system that aims to provide a personalized and friendly experience for travelers searching destinations and tourist attractions, what we call the **Destination Discovery Process**:
-  **Destination Discovery:** Traveler is starting the research and needs assistance to find the best travel destination.
- **Itinerary Build:** Traveler has already chosen the destination and needs help to build a travel itinerary.
- **Destination Exploration:** Traveler is already visiting the destination and needs suggestions on tourist attractions, without defining a previous itinerary.

## Technologies :books:

1. **Flutter**
    - **Usage:** Provides the user interface for the chatbot agent and the management module, enabling the travelers and travel agencies to interact with the system.
1. **Google Maps API**
    - **Usage:** Provides location data, photos and user reviews to support the suggestions of attractions and destinations.
2. **IBM Watson**
    - **Usage:** Powers the chatbot interface, enabling natural language understanding and conversational capabilities to gather the traveler preferences.
3. **Firebase Authentication**
    - **Usage:** Handles user authentication and ensures secure access to the system.

## Contribute :gift:

If you have any idea, suggestion, or saw any error, you can tell me [here (Issues)][issues].

<!---Links utilizados no documento-->

[architecture-jpg]: https://github.com/GustavoHerreroNunes/travel-ai-agent/blob/main/readme-assets/architecture.jpg

[architecture-pdf]: https://github.com/GustavoHerreroNunes/travel-ai-agent/blob/main/readme-assets/architecture.pdf

[issues]: https://github.com/GustavoHerreroNunes/travel-ai-agent/issues