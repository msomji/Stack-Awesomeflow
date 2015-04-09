require 'rails_helper'


feature "User viewing a question page" do
  let(:user) { User.create!(email: "bob@boby.com", password: "12341234")  }
  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}

  before do
    visit new_user_session_path
    find('#user_email').set(user.email)
    find('#user_password').set(user.password)
    click_button('Log in')
  end


  scenario "when user views a question" do
    # when
    visit question_path(question)
    # then
    expect(page).to have_content(question.title)


  end

  scenario "When user tries to update their question, text field are prefilled" do
    visit edit_question_path(question)
    
    expect(page.find("textarea").text).to eq(question.body)

  end

  scenario "when user tries to delete their question" do
    visit edit_question_path(question)
    click_button("Delete")
    expect(page).to have_no_content(question.title) 
    
  end

  
end