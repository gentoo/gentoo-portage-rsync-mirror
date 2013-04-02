# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-4.10.1.ebuild,v 1.5 2013/04/02 20:51:09 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
	KMNAME="kde-dev-scripts"
	KMMODULE="."
else
	eclass="kde4-meta"
	KMNAME="kdesdk"
	KMMODULE="kde-dev-scripts"
fi
inherit ${eclass}

DESCRIPTION="KDE SDK Scripts"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	app-arch/advancecomp
	media-gfx/optipng
	dev-perl/XML-DOM
"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' ${KMMODULE}/CMakeLists.txt || die

	${eclass}_src_prepare
}
