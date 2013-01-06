# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debhelper/debhelper-9.20120830.ebuild,v 1.1 2012/08/31 16:28:32 jer Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Collection of programs that can be used to automate common tasks in debian/rules"
HOMEPAGE="http://packages.qa.debian.org/d/debhelper.html http://joeyh.name/code/debhelper/"
SRC_URI="mirror://debian/pool/main/d/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="nls linguas_de linguas_es linguas_fr test"

RDEPEND="app-arch/dpkg
	dev-perl/TimeDate
	virtual/perl-Getopt-Long
	>=dev-lang/perl-5.10"

DEPEND="${RDEPEND}
	nls? ( >=app-text/po4a-0.24 )
	test? ( dev-perl/Test-Pod )"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-7.4.13-conditional-nls.patch
}

src_compile() {
	tc-export CC
	local USE_NLS=no LANGS=""

	use nls && USE_NLS=yes

	use linguas_de && LANGS="${LANGS} de"
	use linguas_es && LANGS="${LANGS} es"
	use linguas_fr && LANGS="${LANGS} fr"

	emake USE_NLS=${USE_NLS} LANGS="${LANGS}" build
}

src_install() {
	default
	dodoc doc/* debian/changelog
	docinto examples
	dodoc examples/*
	for manfile in *.1 *.7 ; do
		case ${manfile} in
			*.de.?)	use linguas_de \
					&& cp ${manfile} "${T}"/${manfile/.de/} \
					&& doman -i18n=de "${T}"/${manfile/.de/}
				;;
			*.es.?)	use linguas_es \
					&& cp ${manfile} "${T}"/${manfile/.es/} \
					&& doman -i18n=es "${T}"/${manfile/.es/}
				;;
			*.fr.?)	use linguas_fr \
					&& cp ${manfile} "${T}"/${manfile/.fr/} \
					&& doman -i18n=fr "${T}"/${manfile/.fr/}
				;;
			*)	doman ${manfile}
				;;
		esac
	done
}
