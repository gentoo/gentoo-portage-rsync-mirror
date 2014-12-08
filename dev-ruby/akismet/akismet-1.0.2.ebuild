# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/akismet/akismet-1.0.2.ebuild,v 1.1 2014/12/08 10:30:31 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="A Ruby client for the Akismet API"
HOMEPAGE="http://github.com/jonahb/akismet"
SRC_URI="https://github.com/jonahb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

ruby_add_bdepend "test? ( dev-ruby/test-unit:2 )"

each_ruby_test() {
	ruby-ng_testrb-2 -Ilib test/*_test.rb
}
