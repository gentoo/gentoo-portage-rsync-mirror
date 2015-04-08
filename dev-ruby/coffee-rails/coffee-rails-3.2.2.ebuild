# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coffee-rails/coffee-rails-3.2.2.ebuild,v 1.6 2014/08/05 16:00:47 mrueg Exp $

EAPI=4
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit ruby-fakegem

DESCRIPTION="Coffee Script adapter for the Rails asset pipeline"
HOMEPAGE="https://github.com/rails/coffee-rails"

LICENSE="MIT"
SLOT="3.2"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"

IUSE=""

ruby_add_rdepend ">=dev-ruby/coffee-script-2.2.0
	dev-ruby/railties:3.2"

ruby_add_bdepend "test? ( dev-ruby/rails:3.2 )"

all_ruby_prepare() {
	sed -e '/git ls-files/d' -i coffee-rails.gemspec || die

	# Make sure Rails 3.2 is used.
	sed -e '4igem "rails", "~> 3.2.0"' -i test/test_helper.rb || die

	# Apply upstream fix for failing test
	sed -i -e 's/this.CoffeeScript/CoffeeScript Compiler/' test/assets_test.rb || die
}
