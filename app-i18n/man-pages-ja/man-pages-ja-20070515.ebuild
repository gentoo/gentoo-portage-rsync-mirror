# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-ja/man-pages-ja-20070515.ebuild,v 1.7 2014/01/30 20:28:15 vapier Exp $

GENTOO_MAN_P="portage-${PN}-20060415"

DESCRIPTION="A collection of manual pages translated into Japanese"
HOMEPAGE="http://www.linux.or.jp/JM/ http://www.gentoo.gr.jp/jpmain/translation.xml"
SRC_URI="http://www.linux.or.jp/JM/${P}.tar.gz
	http://dev.gentoo.org/~hattya/distfiles/${GENTOO_MAN_P}.tar.gz"

LICENSE="GPL-2+ GPL-2 LGPL-2+ LGPL-2 BSD MIT ISC HPND FDL-1.1+ LDP-1 LDP-1a man-pages Texinfo-manual"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/man"

src_compile() {

	sed -i -e "/^\(man\|shadow\)/s:Y:N:" script/pkgs.list || die

	# remove man pages that are provided by other packages.
	# - sys-apps/shadow +nls
	rm -f manual/*/man1/{chfn,chsh,newgrp,su,passwd,groups}.1
	rm -f manual/*/man8/{vigr,vipw}.8

}

src_install() {

	local x y z pkg

	for x in $(tac script/pkgs.list | grep -v '^[#].*'); do
		if [[ -z "$pkg" ]]; then
			pkg=$x
			continue
		fi

		if [[ "$x" == "N" ]]; then
			pkg=
			continue
		fi

		einfo "install $pkg"

		for y in $(ls -d manual/$pkg/man* 2>/dev/null); do
			doman -i18n=ja $y/*
		done

		pkg=
	done

	dodoc ChangeLog README

	cd "${WORKDIR}"/${GENTOO_MAN_P}

	for x in *; do
		if [ -d "$x" ]; then
			einfo "install $x"

			for z in $(for y in $x/*.[1-9]; do echo ${y##*.}; done | sort | uniq); do
				doman -i18n=ja $x/*.$z
			done
		fi
	done

	newdoc ChangeLog ChangeLog.GentooJP

}

pkg_postinst() {

	echo
	elog "You need to set appropriate LANG variables to use"
	elog "Japanese manpages."
	elog "e.g."
	elog "\tLANG=\"ja_JP.eucJP\""
	elog "\texport LANG"
	echo

}
