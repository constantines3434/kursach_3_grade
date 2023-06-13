using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для EditingDiscipline
    /// </summary>
    public partial class EditingDiscipline : Page
    {

        private Disciplines _selectedDiscipline;
        private string roleUser;

        public EditingDiscipline(Disciplines selectedDisca, string roleUser)
        {
            InitializeComponent();
            Initialization();
            _selectedDiscipline = selectedDisca;
            NameDiscipline.Text = selectedDisca.name_discipline;
            spec.Text = selectedDisca.code_speciality;
            DataContext = _selectedDiscipline;
            this.roleUser = roleUser;
        }
        private void UpdateQuestions()
        {
            _selectedDiscipline.name_discipline = NameDiscipline.Text;
            _selectedDiscipline.code_speciality = spec.Text;
        }

        private void Initialization()
        {
            var DisciplineList = from i in RandomTicketGenerator.GetContext().Disciplines.ToList()
                                 select i;
            DataContext = DisciplineList;
            spec.ItemsSource = DisciplineList;
            spec.SelectedValuePath = "";
            spec.DisplayMemberPath = "code_speciality";
            spec.SelectedIndex = 0;
        }

        private void But_Click_Save_Discipline(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(_selectedDiscipline.name_discipline))
            {
                MessageBox.Show("Корректно напишите вопрос");
                return;
            }

            UpdateQuestions();

            try
            {
             //   RandomTicketGenerator.GetContext().Disciplines.AddOrUpdate(_selectedDiscipline);
                RandomTicketGenerator.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void But_Click_Viewing_Table_Data(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ViewingDisciplineTable(roleUser));
        }
    }
}