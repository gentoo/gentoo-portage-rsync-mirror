# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit-kde-agent/polkit-kde-agent-0.99.0.ebuild,v 1.7 2012/04/25 16:51:10 scarabeus Exp $

EAPI="3"

if [[ ${PV} = *9999* ]]; then
	inherit git
	EGIT_REPO_URI="git://anongit.kde.org/polkit-kde-agent-1"
	EGIT_PROJECT="polkit-kde-agent-1"
else
	MY_P="${P/agent/agent-1}"
	SRC_URI="mirror://kde/stable/apps/KDE4.x/admin/${MY_P}.tar.bz2"
	KDE_LINGUAS="ca ca@valencia cs da de en_GB eo es et fi fr ga
	gl hr hu is it ja km lt nb mai ms nds nl pa pt pt_BR ro ru
	sk sr sr@ijekavian sr@ijekavianlatin sr@latin sv th tr uk zh_TW"
fi
inherit kde4-base

DESCRIPTION="PolKit agent module for KDE."
HOMEPAGE="http://www.kde.org"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=sys-auth/polkit-qt-0.98_pre
"
RDEPEND="${DEPEND}
	!sys-auth/polkit-kde
"

[[ ${PV} = *9999* ]] || S="${WORKDIR}/${MY_P}"
