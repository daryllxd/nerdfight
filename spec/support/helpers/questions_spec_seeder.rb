def create_question
  new_question_attributes = {
    question_text: 'What is the name of our planet?',
    answers: [
      { name: 'Mercury' },
      { name: 'Venus' },
      { name: 'Earth', correct_answer: true }
  ]
  }

  Questions::CreateService.new(new_question_attributes: new_question_attributes).call
end
