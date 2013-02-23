# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.9.5.ebuild,v 1.5 2013/02/23 16:50:58 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdenetwork"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	net-dialup/ppp
"
