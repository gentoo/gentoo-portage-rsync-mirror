# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm-kde/lightdm-kde-0.3.0.ebuild,v 1.1 2012/08/20 12:51:28 johu Exp $

EAPI=4

KDE_MINIMAL="4.8"
KDE_SCM="git"
EGIT_REPONAME="${PN/-kde/}"
KDE_LINGUAS="cs da de el es et fi fr ga hu ja km lt nds nl pl pt pt_BR sk sv uk"
inherit kde4-base

DESCRIPTION="LightDM KDE greeter"
HOMEPAGE="https://projects.kde.org/projects/playground/base/lightdm"
[[ ${PV} = 9999* ]] || SRC_URI="mirror://kde/unstable/${PN}/src/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND=">=x11-misc/lightdm-1.3.2[qt4]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN/-kde}-${PV}
