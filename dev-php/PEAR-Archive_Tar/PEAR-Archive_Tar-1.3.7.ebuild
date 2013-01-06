# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Archive_Tar/PEAR-Archive_Tar-1.3.7.ebuild,v 1.7 2011/03/05 12:13:36 armin76 Exp $

EAPI="2"

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Tar file management class"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
		>=dev-php/PEAR-PEAR-1.8.1
"
PDEPEND="dev-php/pear"
HOMEPAGE="http://pear.php.net/package/Archive_Tar"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/php/Archive
	doins Archive/*

	dodoc docs/*
}
