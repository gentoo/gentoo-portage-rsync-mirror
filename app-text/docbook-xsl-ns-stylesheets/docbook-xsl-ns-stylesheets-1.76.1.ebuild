# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xsl-ns-stylesheets/docbook-xsl-ns-stylesheets-1.76.1.ebuild,v 1.7 2012/02/02 16:15:44 ssuominen Exp $

DESCRIPTION="XSL Stylesheets for Docbook"
HOMEPAGE="http://wiki.docbook.org/topic/DocBookXslStylesheets"
SRC_URI="mirror://sourceforge/docbook/docbook-xsl-ns-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=app-text/build-docbook-catalog-1.4"

S=${WORKDIR}/docbook-xsl-ns-${PV}

# Makefile is broken in this release
RESTRICT=test

# The makefile runs tests, not builds.
src_compile() { :; }

src_test() {
	emake check || die "test failed"
}

src_install() {
	# Create the installation directory
	insinto /usr/share/sgml/docbook/xsl-ns-stylesheets

	local i
	for sheet in $(find . -maxdepth 1 -mindepth 1 -type d); do
		i=$(basename $sheet)
		cd "${S}"/${i}
		for doc in ChangeLog README; do
			if [ -e "$doc" ]; then
				mv ${doc} ${doc}.${i}
				dodoc ${doc}.${i}
				rm ${doc}.${i}
			fi
		done

		doins -r "${S}"/${i}
	done

	# Install misc. docs
	# The changelog is now zipped, and copied as the RELEASE-NOTES, so we
	# don't need to install it
	cd "${S}"
	dodoc AUTHORS BUGS NEWS README RELEASE-NOTES.txt TODO
	doins VERSION
}

pkg_postinst() {
	build-docbook-catalog
}

pkg_postrm() {
	build-docbook-catalog
}
