# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coffee-rails/coffee-rails-3.1.1.ebuild,v 1.3 2012/05/17 10:53:55 tomka Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

inherit ruby-fakegem

DESCRIPTION="Coffee Script adapter for the Rails asset pipeline."
HOMEPAGE="https://github.com/rails/coffee-rails"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"

IUSE=""

ruby_add_rdepend ">=dev-ruby/coffee-script-2.2.0
	dev-ruby/railties:3.1"

all_ruby_prepare() {
	# Test fails on whitespace differences:
	# https://github.com/rails/coffee-rails/issues/20
	rm test/template_handler_test.rb || die
}
