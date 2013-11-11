# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/geomview/geomview-1.9.4.ebuild,v 1.9 2013/11/11 22:16:29 mr_bones_ Exp $

EAPI=1

inherit elisp-common eutils flag-o-matic fdo-mime

DESCRIPTION="Interactive Geometry Viewer"
HOMEPAGE="http://geomview.sourceforge.net"
SRC_URI="
	mirror://sourceforge/${PN}/${P}.tar.bz2
	http://dev.gentoo.org/~jlec/distfiles/geomview.png.tar"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="avg bzip2 debug emacs netpbm pdf zlib"

DEPEND="
	>=x11-libs/motif-2.3:0
	virtual/opengl
	emacs? ( virtual/emacs )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	app-arch/gzip
	virtual/w3m
	bzip2? ( app-arch/bzip2 )
	netpbm? ( >=media-libs/netpbm-10.37.0 )
	pdf? (
		|| ( app-text/xpdf
			app-text/gv
			app-text/epdfview
			app-text/acroread )
	)"

S="${WORKDIR}/${P/_/-}"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	# GNU standard is /usr/share/doc/${PN}, so override this; also note
	# that motion averaging is still experimental.
	if use pdf; then
		local myconf="--docdir=/usr/share/doc/${PF}"
	else
		local myconf="--docdir=/usr/share/doc/${PF} --without-pdfviewer"
	fi

	econf ${myconf} $(use_enable debug d1debug) $(use_with zlib) \
		$(use_enable avg motion-averaging)

	emake || die "make failed"

	if use emacs; then
		cp "${FILESDIR}/gvcl-mode.el" "${S}"
		elisp-compile *.el || die "elisp-compile failed"
	fi

}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon "${WORKDIR}"/geomview.png || die
	make_desktop_entry geomview "GeomView ${PV}" \
		"/usr/share/pixmaps/geomview.png" \
		"Science;Math;Education"

	dodoc AUTHORS ChangeLog NEWS INSTALL.Geomview || die

	if ! use pdf; then
		rm "${D}"/usr/share/doc/${PF}/${PN}.pdf || die
	fi

	if use emacs; then
		elisp-install ${PN} *.el *.elc|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || \
			die "elisp-site-file-install failed"
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog "GeomView expects you to have both Firefox and Xpdf installed for"
	elog "viewing the documentation (this can be changed at runtime)."
	echo ""
	elog "The w3m virtual should handle the HTML browser part, and if"
	elog "you wish to use an alternate PDF viewer, feel free to remove"
	elog "xpdf and use the viewer of your choice (see the docs for how"
	elog "to setup the \'(ui-pdf-viewer VIEWER)\' GCL-command)."

	use emacs && elisp-site-regen
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	use emacs && elisp-site-regen
}
