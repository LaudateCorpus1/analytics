#
# Copyright (C) 2017 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

module Analytics::Extensions::Account
  TAB_ANALYTICS = 33

  def tabs_available(user=nil, opts={})
    tabs = super
    if active? && service_enabled?(:analytics) && grants_right?(user, :view_analytics)
      tabs << {
        id: TAB_ANALYTICS,
        label: t("Analytics"),
        css_class: 'analytics_plugin',
        href: :analytics_department_path
      }
    end
    tabs
  end
end
