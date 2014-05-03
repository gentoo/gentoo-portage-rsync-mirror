# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/http-cookie/http-cookie-1.0.2.ebuild,v 1.2 2014/05/03 07:10:03 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="A ruby library to handle HTTP cookies"
HOMEPAGE="https://github.com/sparklemotion/http-cookie"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/domain_name-0.5:0"

all_ruby_prepare() {
	sed -i -e "/simplecov/d" Rakefile || die
}
