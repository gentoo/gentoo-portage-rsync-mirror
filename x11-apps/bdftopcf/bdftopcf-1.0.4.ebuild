# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/bdftopcf/bdftopcf-1.0.4.ebuild,v 1.7 2013/10/05 04:53:43 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="X.Org bdftopcf application"

KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
RDEPEND="x11-libs/libXfont"
DEPEND="${RDEPEND}"
