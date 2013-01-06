# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-util/font-util-1.3.0.ebuild,v 1.10 2012/08/26 16:02:30 armin76 Exp $

EAPI=4
inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/xorg/font/util"
DESCRIPTION="X.Org font utilities"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

XORG_CONFIGURE_OPTIONS="--with-mapdir=${EPREFIX}/usr/share/fonts/util --with-fontrootdir=${EPREFIX}/usr/share/fonts"
