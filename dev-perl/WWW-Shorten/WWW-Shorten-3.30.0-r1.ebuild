# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Shorten/WWW-Shorten-3.30.0-r1.ebuild,v 1.1 2014/08/26 19:05:50 axs Exp $

EAPI=5

MODULE_AUTHOR=DAVECROSS
MODULE_VERSION=3.03
inherit perl-module

DESCRIPTION="Interface to URL shortening sites"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/libwww-perl
	dev-perl/URI"
DEPEND=">=virtual/perl-Module-Build-0.380.0"
#	test? ( ${RDEPEND}
#		dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage )"

SRC_TEST=online

src_prepare() {
	perl-module_src_prepare
	sed -i -e '/Config::Auto/d' "${S}"/Build.PL || die
}

src_install() {
	perl-module_src_install

	docinto example
	dodoc "${S}"/bin/shorten
	rm -f "${D}"/usr/bin/shorten "${D}"/usr/share/man/man1/shorten.1 || die
}
