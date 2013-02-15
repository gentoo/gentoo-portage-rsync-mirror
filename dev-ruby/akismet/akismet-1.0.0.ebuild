# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/akismet/akismet-1.0.0.ebuild,v 1.1 2013/02/15 06:08:08 flameeyes Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="A Ruby client for the Akismet API"
HOMEPAGE="http://github.com/jonahb/akismet"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

# test file is not present in the gem :(
#
# ruby_add_bdepend "test? ( dev-ruby/test-unit:2 )"
#
#
#each_ruby_test() {
#	ruby-ng_testrb-2 -Ilib test/*_test.rb
#}
