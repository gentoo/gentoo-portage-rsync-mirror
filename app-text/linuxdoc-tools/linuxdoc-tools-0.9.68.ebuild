# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/linuxdoc-tools/linuxdoc-tools-0.9.68.ebuild,v 1.2 2013/03/21 07:09:04 pinkbyte Exp $

EAPI=2

inherit eutils sgml-catalog toolchain-funcs

DESCRIPTION="A toolset for processing LinuxDoc DTD SGML files"
HOMEPAGE="http://packages.qa.debian.org/l/linuxdoc-tools.html"
SRC_URI="mirror://debian/pool/main/l/${PN}/${PN}_${PV}.tar.gz"

LICENSE="MIT SGMLUG"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"

IUSE=""

DEPEND="app-text/openjade
	app-text/opensp
	app-text/sgml-common
	dev-texlive/texlive-fontsrecommended
	>=dev-lang/perl-5.004
	sys-apps/gawk
	sys-apps/groff
	virtual/latex-base"

RDEPEND="${DEPEND}"

sgml-catalog_cat_include "/etc/sgml/linuxdoc.cat" \
	"/usr/share/linuxdoc-tools/linuxdoc-tools.catalog"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-letter.patch" \
		"${FILESDIR}/${PN}-0.9.21-malloc.patch" \
		"${FILESDIR}/${P}-compiler.patch" \
		"${FILESDIR}/${P}-lex.patch"

	# Wrong path for the catalog.
	sed -i -e \
		's,/iso-entities-8879.1986/iso-entities.cat,/sgml-iso-entities-8879.1986/catalog,' \
		perl5lib/LinuxDocTools.pm || die 'sed failed'
}

src_configure() {
	tc-export CC
	econf --with-installed-iso-entities || die "./configure failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "Compilation failed"
}

src_install() {
	# Else fails with sandbox violations
	export VARTEXFONTS="${T}/fonts"

	# Besides the path being wrong, in changing perl5libdir, it cannot find the
	# catalog.
	export SGML_CATALOG_FILES="/usr/share/sgml/sgml-iso-entities-8879.1986/catalog"

	eval `perl -V:installvendorarch`
	einstall \
		perl5libdir="${D}${installvendorarch}" \
		LINUXDOCDOC="${D}/usr/share/doc/${PF}/guide" \
		|| die "Installation failed"

	insinto /usr/share/texmf/tex/latex/misc
	doins tex/*.sty || die

	dodoc ChangeLog README || die
}
