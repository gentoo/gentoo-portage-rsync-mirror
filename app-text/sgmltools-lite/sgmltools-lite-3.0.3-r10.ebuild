# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgmltools-lite/sgmltools-lite-3.0.3-r10.ebuild,v 1.15 2011/04/25 18:51:36 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python sgml-catalog

DESCRIPTION="Python interface to SGML software in a DocBook/OpenJade env"
HOMEPAGE="http://sgmltools-lite.sourceforge.net/"
SRC_URI="mirror://sourceforge/sgmltools-lite/${P}.tar.gz
	mirror://sourceforge/sgmltools-lite/nw-eps-icons-0.0.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="jadetex"

DEPEND="app-text/sgml-common
	~app-text/docbook-sgml-dtd-3.1
	app-text/docbook-dsssl-stylesheets
	app-text/openjade
	jadetex? ( app-text/jadetex )
	|| (
		www-client/w3m
		www-client/lynx )"

sgml-catalog_cat_include "/etc/sgml/sgml-lite.cat" \
	"/usr/share/sgml/stylesheets/sgmltools/sgmltools.cat"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Remove CVS directories from the tree
	find . -name CVS | xargs rm -rf
}

src_compile() {
	default
}

src_install() {
	einstall etcdir="${D}"/etc/sgml || die

	dodoc ChangeLog POSTINSTALL README*
	dohtml -r .

	cd "${WORKDIR}"/nw-eps-icons-0.0.1/images
	insinto /usr/share/sgml/docbook/dsssl-stylesheets/images
	doins *.eps

	cd callouts
	insinto /usr/share/sgml/docbook/dsssl-stylesheets/images/callouts
	doins *.eps

	rm "${D}"/etc/sgml/catalog.{suse,rh62}

	# Remove file provided by sgml-common
	rm "${D}"/usr/bin/sgmlwhich

	# Remove the backends that require jadetex
	use jadetex || \
		rm "${D}"/usr/share/sgml/misc/sgmltools/python/backends/{Dvi,Ps,Pdf,JadeTeX}.py

	# List of backends to alias with sgml2*
	# Do not provide sgml2{txt,rtf,html} anymore, they are part of
	# linuxdoc-tools
	local BACKENDS=""
	use jadetex && BACKENDS="ps dvi pdf"

	# Create simple alias scripts that people are used to
	# And make the manpages for those link to the sgmltools-lite manpage
	mandir="${D}"/usr/share/man/man1
	ScripTEXT="#!/bin/sh\n/usr/bin/sgmltools --backend="
	for back in ${BACKENDS}
	do
		echo -e ${ScripTEXT}${back} '$*' > sgml2${back}
		exeinto /usr/bin
		doexe sgml2${back}

		cd ${mandir}
		ln -sf sgmltools-lite.1.gz sgml2${back}.1.gz
		cd "${S}"
	done
}

pkg_postinst() {
	python_mod_optimize /usr/share/sgml/misc/sgmltools/python
	sgml-catalog_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup /usr/share/sgml/misc/sgmltools/python
	sgml-catalog_pkg_postrm
}
