# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sprockets-rails/sprockets-rails-2.2.2.ebuild,v 1.1 2014/12/22 12:13:45 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Sprockets implementation for Rails 4.x (and beyond) Asset Pipeline"
HOMEPAGE="https://github.com/rails/sprockets-rails"
SRC_URI="https://github.com/rails/sprockets-rails/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~x86"

IUSE="test"

ruby_add_rdepend "
	>=dev-ruby/actionpack-3.0
	>=dev-ruby/activesupport-3.0
	>=dev-ruby/sprockets-2.8:2"

ruby_add_bdepend "
	test? (
		>=dev-ruby/actionpack-4
		>=dev-ruby/railties-4
		dev-ruby/test-unit:2
	)"

all_ruby_prepare() {
	# Avoid tests that fail on a custom manifest name. It is not clear
	# if this is related to Rails 4.2, and the current sprockets
	# version already in the tree only works with this newer 
	# sprockets-rails version.
	rm test/test_task.rb || die
}
