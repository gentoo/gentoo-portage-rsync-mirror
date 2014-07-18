# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qscintilla/qscintilla-2.8.3.ebuild,v 1.1 2014/07/18 19:50:08 pesa Exp $

EAPI=5

inherit eutils qmake-utils

MY_P=QScintilla-gpl-${PV}

DESCRIPTION="A Qt port of Neil Hodgson's Scintilla C++ editor class"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/qscintilla/intro"
SRC_URI="mirror://sourceforge/pyqt/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0/11"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

DEPEND="
	>=dev-qt/designer-4.8.5:4
	>=dev-qt/qtcore-4.8.5:4
	>=dev-qt/qtgui-4.8.5:4
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/${PN}-2.8.3-designer.patch"
)

src_unpack() {
	default

	# Sub-slot sanity check
	local subslot=${SLOT#*/}
	local version=$(sed -nre 's:.*VERSION\s*=\s*([0-9\.]+):\1:p' "${S}"/Qt4Qt5/qscintilla.pro)
	local major=${version%%.*}
	if [[ ${subslot} != ${major} ]]; then
		eerror
		eerror "Ebuild sub-slot (${subslot}) does not match QScintilla major version (${major})"
		eerror "Please update SLOT variable as follows:"
		eerror "    SLOT=\"${SLOT%%/*}/${major}\""
		eerror
		die "sub-slot sanity check failed"
	fi
}

src_prepare() {
	[[ ${PATCHES[@]} ]] && epatch "${PATCHES[@]}"
}

src_configure() {
	pushd Qt4Qt5 > /dev/null
	einfo "Configuration of qscintilla"
	eqmake4 qscintilla.pro
	popd > /dev/null

	pushd designer-Qt4Qt5 > /dev/null
	einfo "Configuration of designer plugin"
	eqmake4 designer.pro
	popd > /dev/null
}

src_compile() {
	pushd Qt4Qt5 > /dev/null
	einfo "Building of qscintilla"
	emake
	popd > /dev/null

	pushd designer-Qt4Qt5 > /dev/null
	einfo "Building of designer plugin"
	emake
	popd > /dev/null
}

src_install() {
	pushd Qt4Qt5 > /dev/null
	einfo "Installation of qscintilla"
	emake INSTALL_ROOT="${D}" install
	popd > /dev/null

	pushd designer-Qt4Qt5 > /dev/null
	einfo "Installation of designer plugin"
	emake INSTALL_ROOT="${D}" install
	popd > /dev/null

	dodoc NEWS

	if use doc; then
		dohtml doc/html-Qt4Qt5/*
		insinto /usr/share/doc/${PF}
		doins -r doc/Scintilla
	fi
}
