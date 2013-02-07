# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.10.0.ebuild,v 1.1 2013/02/07 04:57:40 alexxy Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdenetwork"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	net-dialup/ppp
"
