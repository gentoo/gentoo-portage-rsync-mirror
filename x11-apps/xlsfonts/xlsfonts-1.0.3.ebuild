# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xlsfonts/xlsfonts-1.0.3.ebuild,v 1.12 2010/11/01 12:54:47 scarabeus Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X.Org xlsfonts application"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
