# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/netrc/netrc-0.9.0.ebuild,v 1.1 2014/12/07 12:43:55 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_EXTRADOC="changelog.txt Readme.md"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="This library reads and writes .netrc files"
HOMEPAGE="https://github.com/geemus/netrc"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

all_ruby_prepare() {
	sed -e '/test_encrypted_roundtrip/a skip "depends on external gpg test keys"' -i test/test_netrc.rb || die
}

each_ruby_test() {
	${RUBY} -S testrb test/test_*.rb || die
}
