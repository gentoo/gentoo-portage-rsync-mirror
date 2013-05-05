# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/org-mode/org-mode-7.9.2.ebuild,v 1.8 2013/05/05 16:51:24 ulm Exp $

EAPI=4
NEED_EMACS=22

inherit elisp

DESCRIPTION="An Emacs mode for notes and project planning"
HOMEPAGE="http://www.orgmode.org/"
SRC_URI="http://orgmode.org/org-${PV}.tar.gz"

LICENSE="GPL-3+ FDL-1.3+ contrib? ( GPL-2+ MIT ) odt-schema? ( OASIS-Open )"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-macos"
IUSE="contrib doc odt-schema"
RESTRICT="test"

DEPEND="doc? ( virtual/texi2dvi )"

S="${WORKDIR}/org-${PV}"
# Remove autoload file to make sure that it is regenerated with
# the right Emacs version.
ELISP_REMOVE="lisp/org-install.el"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake datadir="${EPREFIX}${SITEETC}/${PN}"
	use doc && emake pdf card
}

src_install() {
	emake \
		DESTDIR="${D}" \
		ETCDIRS="styles $(use odt-schema && echo schema)" \
		lispdir="${EPREFIX}${SITELISP}/${PN}" \
		datadir="${EPREFIX}${SITEETC}/${PN}" \
		install

	cp "${FILESDIR}/${SITEFILE}" "${T}/${SITEFILE}"

	if use contrib; then
		elisp-install ${PN}/contrib contrib/lisp/*org*.el || die
		insinto /usr/share/doc/${PF}/contrib
		doins -r contrib/README contrib/babel contrib/scripts
		find "${ED}/usr/share/doc/${PF}/contrib" -type f -name '.*' \
			-exec rm -f '{}' '+'
		# add the contrib subdirectory to load-path
		sed -i -e 's:\(.*@SITELISP@\)\(.*\):&\n\1/contrib\2:' \
			"${T}/${SITEFILE}" || die
	fi

	elisp-site-file-install "${T}/${SITEFILE}" || die
	dodoc README doc/orgcard.txt etc/ORG-NEWS
	use doc && dodoc doc/org.pdf doc/orgcard.pdf doc/orgguide.pdf
}
