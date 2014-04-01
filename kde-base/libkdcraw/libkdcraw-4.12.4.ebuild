# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdcraw/libkdcraw-4.12.4.ebuild,v 1.1 2014/04/01 18:10:01 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE digital camera raw image library wrapper"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-libs/libraw-0.16_beta1-r1:=
"
RDEPEND="${DEPEND}"
