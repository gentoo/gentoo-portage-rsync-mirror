# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kportagetray/kportagetray-0.2.4-r1.ebuild,v 1.2 2014/03/21 19:27:00 johu Exp $

EAPI=5

KDE_LINGUAS="pt_BR"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit kde4-base python-r1

EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"

DESCRIPTION="Graphical application for Portage's daily tasks"
HOMEPAGE="http://gitorious.org/kportagetray"
[[ ${PV} == 9999* ]] || SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="4"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-python/PyQt4[svg,dbus]
	$(add_kdebase_dep pykde4)
"
RDEPEND="${DEPEND}
	app-portage/eix
	app-portage/genlop
	$(add_kdebase_dep kdesu)
	$(add_kdebase_dep knotify)
	$(add_kdebase_dep konsole)
"

PATCHES=(
	"${FILESDIR}/${P}-fix_class_name.patch"
	"${FILESDIR}/${P}-kdesu46.patch"
)
