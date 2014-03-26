# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/root-docs/root-docs-5.34.18-r1.ebuild,v 1.1 2014/03/26 20:38:20 bicatali Exp $

EAPI=5

ROOT_PN="root"
ROOFIT_DOC_PV=2.91-33
TMVA_DOC_PV=4.2.0

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="ftp://root.cern.ch/${ROOT_PN}/${ROOT_PN}_v${PV}.source.tar.gz"
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
fi

inherit eutils multilib toolchain-funcs virtualx

DESCRIPTION="Documentation for ROOT Data Analysis Framework"
HOMEPAGE="http://root.cern.ch/drupal"
DOC_URI="ftp://root.cern.ch/root"
SRC_URI="${SRC_URI}
	math? (
		http://tmva.sourceforge.net/docu/TMVAUsersGuide.pdf -> TMVAUsersGuide-v${TMVA_DOC_PV}.pdf
		${DOC_URI}/RooFit_Users_Manual_${ROOFIT_DOC_PV}.pdf
		metric? ( ${DOC_URI}/spectrum/Spectrum.pdf -> Spectrum-${PV}.pdf )
		!metric? ( ${DOC_URI}/spectrum/SpectrumLetter.pdf -> SpectrumLetter-${PV}.pdf ) )
	metric? (
		${DOC_URI}/ROOTUsersGuideA4.pdf -> ROOTUsersGuideA4-${PV}.pdf
		${DOC_URI}/primer/ROOTPrimer.pdf -> ROOTPrimer-${PV}.pdf )
	!metric? (
		${DOC_URI}/ROOTUsersGuideLetter.pdf -> ROOTUsersGuideLetter-${PV}.pdf
		${DOC_URI}/primer/ROOTPrimerLetter.pdf -> ROOTPrimerLetter-${PV}.pdf )
	api? (
		${HOMEPAGE}/sites/default/files/rootdrawing-logo.png
		${HOMEPAGE}/sites/all/themes/newsflash/images/blue/root-banner.png
		${HOMEPAGE}/sites/all/themes/newsflash/images/info.png )"

SLOT="0"
LICENSE="LGPL-2.1"
IUSE="api +math +metric"

VIRTUALX_REQUIRED="api"

DEPEND="
	~sci-physics/root-${PV}[X,graphviz,opengl]
	virtual/pkgconfig"
RDEPEND=""

S="${WORKDIR}/${ROOT_PN}"
DOC_DIR="/usr/share/doc/${ROOT_PN}-${PV}"

src_prepare() {
	# Make html docs self-consistent for offline work (based on Fedora spec)
	if use api; then
		epatch \
			"${FILESDIR}"/${PN}-5.34.01-makehtml.patch \
			"${FILESDIR}"/${PN}-5.34.18-html.patch
		# make images local
		sed -i \
			-e 's!http://root.cern.ch/drupal/sites/all/themes/newsflash/images/blue/!!' \
			etc/html/ROOT.css || die "html sed failed"
		sed -i \
			-e 's!http://root.cern.ch/drupal/sites/all/themes/newsflash/images/!!' \
			etc/html/ROOT.css || die "html sed failed"
		sed -i \
			-e 's!http://root.cern.ch/drupal/sites/default/files/!!' \
			etc/html/header.html || die "html sed failed"

		cp "${DISTDIR}"/{rootdrawing-logo.png,root-banner.png,info.png} \
			etc/html ||	die "html preparation failed"
	fi
	# prefixify the configure script
	sed -i \
		-e "s:/usr:${EPREFIX}/usr:g" \
		configure || die "prefixify configure failed"
}

src_configure() {
	# we need only to setup paths here, html docs doesn't depend on USE flags
	if use api; then
		./configure \
			--prefix="${EPREFIX}/usr" \
			--etcdir="${EPREFIX}/etc/root" \
			--libdir="${EPREFIX}/usr/$(get_libdir)/${PN}" \
			--docdir="${EPREFIX}/usr/share/doc/${PF}" \
			--tutdir="${EPREFIX}/usr/share/doc/${PF}/examples/tutorials" \
			--testdir="${EPREFIX}/usr/share/doc/${PF}/examples/tests" \
			--with-cc="$(tc-getCC)" \
			--with-cxx="$(tc-getCXX)" \
			--with-f77="$(tc-getFC)" \
			--with-ld="$(tc-getCXX)" \
			--with-afs-shared=yes \
			--with-llvm-config="${EPREFIX}/usr/bin/llvm-config" \
			--with-sys-iconpath="${EPREFIX}/usr/share/pixmaps" \
			--nohowto
	fi
}

src_compile() {
	if use html; then
		# video drivers may want to access hardware devices
		cards=$(echo -n /dev/dri/card* /dev/ati/card* /dev/nvidiactl* | sed 's/ /:/g')
		[[ -n "${cards}" ]] && addpredict "${cards}"

		ROOTSYS="${S}" Xemake html
		# if root.exe crashes, return code will be 0 due to gdb attach,
		# so we need to check if last html file was generated;
		# this check is volatile and can't catch crash on the last file.
		[[ -f htmldoc/timespec.html ]] || die "html doc generation crashed"
	fi
}

src_install() {
	insinto ${DOC_DIR}

	if use metric; then
		doins "${DISTDIR}"/ROOTUsersGuideA4-${PV}.pdf
		doins "${DISTDIR}"/ROOTPrimer-${PV}.pdf
		use math && doins "${DISTDIR}"/Spectrum-${PV}.pdf
	else
		doins "${DISTDIR}"/ROOTUsersGuideLetter-${PV}.pdf
		doins "${DISTDIR}"/ROOTPrimerLetter-${PV}.pdf
		use math && doins "${DISTDIR}"/SpectrumLetter-${PV}.pdf
	fi
	use math && doins \
		"${DISTDIR}"/RooFit_Users_Manual_${ROOFIT_DOC_PV}.pdf \
		"${DISTDIR}"/TMVAUsersGuide-v${TMVA_DOC_PV}.pdf

	if use api; then
		# too large data to copy
		dodir ${DOC_DIR}/html
		mv htmldoc/* "${ED}${DOC_DIR}/html/" || die
		docompress -x ${DOC_DIR}/html
	fi
}
