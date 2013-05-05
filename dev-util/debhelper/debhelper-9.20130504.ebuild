# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debhelper/debhelper-9.20130504.ebuild,v 1.1 2013/05/05 14:08:52 jer Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="Collection of programs that can be used to automate common tasks in debian/rules"
HOMEPAGE="http://packages.qa.debian.org/d/debhelper.html http://joeyh.name/code/debhelper/"
SRC_URI="mirror://debian/pool/main/d/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls test"
DH_LINGUAS=( de es fr )
IUSE+=" ${DH_LINGUAS[@]/#/linguas_}"

RDEPEND="
	>=dev-lang/perl-5.10
	app-arch/dpkg
	dev-perl/TimeDate
	virtual/perl-Getopt-Long
"
DEPEND="${RDEPEND}
	nls? ( >=app-text/po4a-0.24 )
	test? ( dev-perl/Test-Pod )
"

S=${WORKDIR}/${PN}

src_compile() {
	tc-export CC

	if use nls; then
		local LANGS="" lingua
		for lingua in ${DH_LINGUAS[@]}; do
			use linguas_${lingua} && LANGS+=" ${lingua}"
		done
	fi

	emake \
		USE_NLS=$(usex nls) \
		LANGS="${LANGS}" \
		build
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
