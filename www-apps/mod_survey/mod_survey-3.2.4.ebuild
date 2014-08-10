# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mod_survey/mod_survey-3.2.4.ebuild,v 1.6 2014/08/10 20:13:58 slyfox Exp $

inherit webapp

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"

DESCRIPTION="XML-defined web questionnaires as a plug-in module using Apache"
HOMEPAGE="http://www.modsurvey.org"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc mysql nls postgres"

# Note: sw is invalid LINGUAS value, it should be sv instead.
# commented out since I have zero interested in sed-ing the code
# for this screw-up.
LANGS="en de fr it" # sv
for i in ${LANGS} ; do
	IUSE="${IUSE} linguas_${i}"
done

MY_PN=${PN/_/}
MY_PV=${PV/_/-}
S=${WORKDIR}/${PN}
SRC_URI="http://www.modsurvey.org/download/tarballs/${MY_PN}-${MY_PV}.tgz
	doc? ( http://www.modsurvey.org/download/tarballs/${MY_PN}-docs-${MY_PV}.tgz )"

DEPEND=">=dev-lang/perl-5.6.1"
RDEPEND="${DEPEND}
		>=www-apache/mod_perl-1.99
		postgres? ( >=dev-perl/DBI-1.38 dev-perl/DBD-Pg )
		mysql? ( >=dev-perl/DBI-1.38 dev-perl/DBD-mysql )
		>=virtual/perl-CGI-3.0.0"
LICENSE="GPL-2"

pkg_setup() {
	# unfortunatly, this program only allows for one lang, so only the first
	# supported entry in LINGUAS is used
	if use nls ; then
		for i in ${LINGUAS} ; do
			if has linguas_${i} ${IUSE} ; then
				if use linguas_${i} ; then
					locallang="${i}"
					ewarn "Due to the limitations of this package, it will be built"
					ewarn "only with ${i} LINGUAS support. If this is not what"
					ewarn "you intended, please place the language you desire"
					ewarn "as _first_ in the list of LINGUAS in /etc/make.conf"
					ewarn
					break
				fi
			else
				einfo "LINGUAS=${i} is not supported by ${P}"
				shift
			fi
		done
	fi
	if [[ -z ${locallang} ]] ; then
		 use nls && ewarn "None of ${LINGUAS} supported, sorry. Will use English."
		 locallang="en"
	fi
	webapp_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f docs/LICENSE.txt
	sed "s|\$lang = \"en\"|\$lang = \"${locallang}\"|" -i installer.pl
	sed -i "s|/usr/local/mod_survey/|${D}/usr/lib/mod_survey/|g" installer.pl
	use doc && unpack ${MY_PN}-docs-${PV}.tgz
}

src_install() {
	webapp_src_preinst

	dodir /usr/lib/mod_survey
	dodir /var/lib/mod_survey/data
	dodir ${MY_HOSTROOTDIR}/${PN}

	dodoc README.txt docs/*

	perl installer.pl < /dev/null > /dev/null 2>&1
	dosed /usr/lib/mod_survey/survey.conf
	dosed "s|/usr/lib/mod_survey/data/|/var/lib/mod_survey/data/|" /usr/lib/mod_survey/survey.conf

	mv "${D}"/usr/lib/mod_survey/survey.conf "${D}"/${MY_HOSTROOTDIR}/${PN}
	rm -rf "${D}"/usr/lib/mod_survey/webroot "${D}"/usr/lib/mod_survey/data

	cp -R webroot/* "${D}"/${MY_HTDOCSDIR}

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_hook_script "${FILESDIR}"/reconfig
	webapp_src_install

	fowners apache:apache /var/lib/mod_survey/data
}
