# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kguiaddons/kguiaddons-5.5.0.ebuild,v 1.1 2014/12/17 21:24:20 mrueg Exp $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework providing assorted high-level user interface components"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE=""

RDEPEND="
	dev-qt/qtgui:5
	dev-qt/qtx11extras:5
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	x11-libs/libxcb
	x11-proto/xproto
"
