module Modiz
  def self.error_messages
    { NoDescriptionFound: "Je ne trouve pas la description dans %{resource}, la description est tout ce qui suit le caractère ')'",
      NoStepDelimiter: "Je ne reconnais pas de ligne qui contient ## Etapes, réfère toi au modèle NEW.md dans le dossier Draft",
      NoChallengeDelimiter: "Je ne reconnais pas de ligne qui contient ## Challenge, réfère toi au modèle NEW.md dans le dossier Draft",
      NoStepsContent: "Je ne reconnais pas de lignes qui contient au moins une étape, avec un titre et une description.",
      NoChallengeContent: "Je ne vois pas de lignes qui décrivent le challenge.",
      NoQuestTitle: "Je ne reconnais pas le titre de quête. Ce doit être la première ligne du fichier et commencer par '# '",
      NoQuestObjectives: "Je ne reconnais pas l'objectif. La Quête doit contenir une liste objectifs avant la section Etapes ",
      NoQuestDescription: "Je ne reconnais pas le description de quêtes. Donnez un peu de contexte tout de même !",
      NoStepTitle: "Je n'ai pas réussi à trouver le titre de l'étape. Les titres d'étapes commencent par '### ' et se trouve après la section ##Etape, ligne :",
      NoChallengeTitle: "Je ne reconnais aucun titre pour le challenge.",
      NoChallengeCriteriaMarkup: "Ta quête doit contenir le titre '### Critères de validation' ou '### Validation criteria'.",
      NoChallengeDescription: "Le challenge mérite d'être décrit, non ?",
      NoChallengeCriteria: "Ta quête doit contenir une liste de critères.",
      InvalidLink: "Les lien(s) suivant n'est(ne sont) pas valide(s) : "
    }
  end
end
