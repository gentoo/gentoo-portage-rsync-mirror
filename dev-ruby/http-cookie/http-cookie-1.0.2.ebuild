# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/http-cookie/http-cookie-1.0.2.ebuild,v 1.1 2013/12/13 09:23:37 mrueg Exp $

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

all_ruby_prepare() {
	sed -i -e "/simplecov/d" Rakefile || die
}
