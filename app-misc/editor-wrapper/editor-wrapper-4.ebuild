# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/editor-wrapper/editor-wrapper-4.ebuild,v 1.17 2014/01/18 03:03:10 vapier Exp $

EAPI=4

DESCRIPTION="Wrapper scripts that will execute EDITOR or PAGER"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

S="${WORKDIR}"

src_prepare() {
	sed -e 's/@VAR@/EDITOR/g' "${FILESDIR}/${P}.sh" >editor || die
	sed -e 's/@VAR@/PAGER/g'  "${FILESDIR}/${P}.sh" >pager  || die
	if use prefix ; then
		sed -i \
			-e "s:#!/bin/sh:#!/usr/bin/env sh:" \
			-e "s: /etc/profile: \"${EPREFIX}/etc/profile\":" \
			editor pager || die
	fi
}

src_install() {
	exeinto /usr/libexec
	doexe editor pager
}
