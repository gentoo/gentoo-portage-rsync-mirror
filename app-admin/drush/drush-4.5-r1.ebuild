# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/drush/drush-4.5-r1.ebuild,v 1.2 2012/12/25 04:36:13 ramereth Exp $

EAPI="4"

DESCRIPTION="Drush is a command line shell and scripting interface for Drupal"
HOMEPAGE="http://drupal.org/project/drush"
SRC_URI="http://ftp.drupal.org/files/projects/${PN}-7.x-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

DEPEND="dev-lang/php[cli,simplexml]
	dev-php/pear
	dev-php/PEAR-Console_Table"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e \
		"s!/share/doc/drush!/share/doc/${PF}!" \
		-e "s!README\.txt!\0.bz2!g" \
		includes/environment.inc || die
	sed -i -e "s!\.php'!.php.bz2'!" commands/core/docs.drush.inc || die
}

src_install() {
	local docs="README.txt docs"
	use examples && docs="${docs} examples"
	insinto /usr/share/drush
	doins -r .
	exeinto /usr/share/drush
	doexe drush
	dosym /usr/share/drush/drush /usr/bin/drush
	dodoc -r ${docs}
	# cleanup
	for i in ${docs} LICENSE.txt drush.bat examples includes/.gitignore ; do
		rm -rf "${D}/usr/share/drush/${i}"
	done
	keepdir /etc/drush
}
