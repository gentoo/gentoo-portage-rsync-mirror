# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.11.2.ebuild,v 1.2 2013/12/08 14:07:44 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE: A dialer and front-end to pppd."
HOMEPAGE="http://www.kde.org/applications/internet/kppp"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	net-dialup/ppp
"
