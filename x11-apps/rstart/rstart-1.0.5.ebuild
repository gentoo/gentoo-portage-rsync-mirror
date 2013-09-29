# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/rstart/rstart-1.0.5.ebuild,v 1.2 2013/09/29 11:08:22 ago Exp $

EAPI=5

inherit xorg-2

DESCRIPTION="X.Org rstart application"
KEYWORDS="amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="x11-proto/xproto"
DEPEND="${RDEPEND}"
