# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmt/cmt-1.24.ebuild,v 1.2 2012/06/07 21:28:44 zmedico Exp $

EAPI=4
inherit eutils elisp-common multilib toolchain-funcs versionator

CPV=($(get_version_components ${PV}))
CMT_PV=v${CPV[0]}r${CPV[1]}

DESCRIPTION="Cross platform configuration management environment"
HOMEPAGE="http://www.cmtsite.org/"
SRC_URI="http://www.cmtsite.org/${CMT_PV}/CMT${CMT_PV}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs java doc"

DEPEND="emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}
	java? ( virtual/jdk )"

S="${WORKDIR}/CMT/${CMT_PV}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.22-limits.patch
}

src_configure() {
	cd "${S}"/mgr
	./INSTALL
	source setup.sh
}

src_compile() {
	cd "${S}"/mgr
	emake -j1 \
		cpp="$(tc-getCXX)" \
		cppflags="${CXXFLAGS}" \
		cpplink="$(tc-getCXX) ${LDFLAGS}"

	sed -i -e "s:${WORKDIR}:${EPREFIX}/usr/$(get_libdir):g" setup.*sh || die
	cd "${S}"
	mv src/demo .
	rm -f ${CMTBIN}/*.o

	if use emacs; then
		elisp-compile doc/cmt-mode.el || die
	fi
}

src_install() {
	CMTDIR="${EPREFIX}"/usr/$(get_libdir)/CMT/${CMT_PV}
	dodir ${CMTDIR}
	cp -pPR mgr src ${CMTBIN} "${ED}"/${CMTDIR} || die
	dodir /usr/bin
	dosym ${CMTDIR}/${CMTBIN}/cmt.exe /usr/bin/cmt

	cat > 99cmt <<-EOF
		 CMTROOT="${CMTDIR}"
		 CMTBIN="$(uname)-$(uname -m | sed -e 's# ##g')"
		 CMTCONFIG="$(${CMTROOT}/mgr/cmt_system.sh)"
	EOF
	if use java; then
		cp -pPR java "${ED}"/${CMTDIR}
		echo "#!${EPREFIX}/bin/sh" > jcmt
		echo "java cmt_parser" >> jcmt
		exeinto /usr/bin
		doexe jcmt
		echo "CLASSPATH=\"${CMTDIR}/java/cmt.jar\"" >> 99cmt
	fi

	doenvd 99cmt
	dodoc ChangeLog doc/*.txt
	dohtml doc/{ChangeLog,ReleaseNotes}.html

	if use doc; then
		emake -C mgr gendoc
		insinto /usr/share/doc/${PF}
		doins -r doc/{CMTDoc,CMTFAQ}.{html,pdf} doc/Images
		doins -r demo
	fi

	if use emacs; then
		elisp-install ${PN} doc/cmt-mode.{el,elc} || die
		elisp-site-file-install "${FILESDIR}"/80cmt-mode-gentoo.el || die
	fi
}

pkg_postinst () {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
