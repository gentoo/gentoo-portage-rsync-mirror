# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/jovie/jovie-4.10.2.ebuild,v 1.5 2013/05/01 11:50:34 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Jovie is a text to speech application"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-accessibility/speech-dispatcher
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.10.1-speechd-0.8.patch" )
