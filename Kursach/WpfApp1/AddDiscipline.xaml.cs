using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для AddDiscipline.xaml
    /// </summary>
    public partial class AddDiscipline : Page
    {
        private string roleUser;
        public AddDiscipline(string roleUser)
        {
            InitializeComponent();
            Initialization();
            DataContext = NewDiscipline();
            this.roleUser = roleUser;
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
        private Disciplines NewDiscipline()
        {
            return new Disciplines
            {
                name_discipline = NameDiscipline.Text,
                code_speciality = spec.Text
            };
        }
        private void But_Click_Save_Discipline(object sender, RoutedEventArgs e)
        {
            var currentDiscipline = NewDiscipline();
            if (string.IsNullOrWhiteSpace(currentDiscipline.name_discipline))
            {
                MessageBox.Show("Корректно напишите название дисциплины");
                return;
            }
            try
            {
                RandomTicketGenerator.GetContext().Disciplines.Add(currentDiscipline);
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
