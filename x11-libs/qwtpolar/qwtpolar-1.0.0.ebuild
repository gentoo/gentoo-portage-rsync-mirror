# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qwtpolar/qwtpolar-1.0.0.ebuild,v 1.2 2011/12/23 07:01:15 jlec Exp $

EAPI=4

inherit multilib qt4-r2

DESCRIPTION="Library for displaying values on a polar coordinate system"
HOMEPAGE="http://qwtpolar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="qwt"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qwt:6[svg]"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	sed -i \
		-e "/QWT_POLAR_INSTALL_PREFIX /s:=.*$:= ${EPREFIX}/usr:g" \
		-e "/QWT_POLAR_INSTALL_LIBS/s:lib:$(get_libdir):g" \
		-e "/QWT_POLAR_INSTALL_DOCS/s:doc:share/doc/${PF}:g" \
		-e "/QWT_POLAR_INSTALL_PLUGINS/s:=.*$:= ${EPREFIX}/usr/$(get_libdir)/qt4/plugins/designer6/:g" \
		-e "/QWT_POLAR_INSTALL_FEATURES/s:=.*$:= ${EPREFIX}/usr/$(get_libdir)/qt4/plugins/features6/:g" \
		-e "/= QwtPolarDesigner/ d" \
		${PN}config.pri || die

	sed -i \
		-e "s:{QWT_POLAR_ROOT}/lib:{QWT_POLAR_ROOT}/$(get_libdir):" \
		src/src.pro || die
	echo "INCLUDEPATH += ${EPREFIX}/usr/include/qwt6" >> src/src.pro
	cat >> designer/designer.pro <<- EOF
	INCLUDEPATH += "${EPREFIX}"/usr/include/qwt6
	LIBS += -L"${S}"/$(get_libdir)
	EOF
}
