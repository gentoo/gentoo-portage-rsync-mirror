# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/proofgeneral/proofgeneral-4.0.ebuild,v 1.2 2010/12/07 01:50:23 ulm Exp $

EAPI=3
NEED_EMACS=23

inherit elisp

MY_PN="ProofGeneral"
DESCRIPTION="A generic interface for proof assistants"
HOMEPAGE="http://proofgeneral.inf.ed.ac.uk/"
SRC_URI="http://proofgeneral.inf.ed.ac.uk/releases/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-emacs/mmm-mode-0.4.8-r2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	sed -i -e '/^OTHER_ELISP/s:contrib/mmm::' Makefile || die
}

src_compile() {
	# removed precompiled lisp files shipped with 4.0
	emake clean
	emake -j1 compile EMACS=emacs || die
}

src_install() {
	emake -j1 install EMACS=emacs PREFIX="${D}"/usr || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${MY_PN} || die

	doinfo doc/*.info* || die
	doman doc/proofgeneral.1 || die
	dohtml doc/ProofGeneral/*.html doc/PG-adapting/*.html || die
	dodoc AUTHORS BUGS CHANGES COMPATIBILITY FAQ INSTALL README REGISTER

	# clean up
	rm -rf "${D}/usr/share/emacs/site-lisp/site-start.d"
	rm -rf "${D}/usr/share/application-registry"
	rm -rf "${D}/usr/share/mime-info"
}

pkg_postinst() {
	elisp-site-regen
	elog "Please register your use of Proof General on the web at:"
	elog "  http://proofgeneral.inf.ed.ac.uk/register "
	elog "(see the REGISTER file for more information)"
}
