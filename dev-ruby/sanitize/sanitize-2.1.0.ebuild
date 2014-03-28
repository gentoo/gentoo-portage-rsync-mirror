# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sanitize/sanitize-2.1.0.ebuild,v 1.1 2014/03/28 09:19:22 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="HISTORY.md README.md"

inherit ruby-fakegem

DESCRIPTION="Sanitize is a whitelist-based HTML sanitizer"
HOMEPAGE="https://github.com/rgrove/sanitize"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE="test"

ruby_add_rdepend ">=dev-ruby/nokogiri-1.4.4"
ruby_add_bdepend "test? ( dev-ruby/minitest )"

each_ruby_test() {
	${RUBY} -Ilib test/test_sanitize.rb || die
}
