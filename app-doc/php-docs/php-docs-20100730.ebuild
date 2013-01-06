# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/php-docs/php-docs-20100730.ebuild,v 1.1 2010/08/02 17:41:26 mabi Exp $

EAPI="3"

DESCRIPTION="HTML documentation for PHP"
HOMEPAGE="http://www.php.net/download-docs.php"

MY_PN="php_manual"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="+linguas_en"
SRC_URI="linguas_en? ( http://www.php.net/distributions/manual/${MY_PN}_en.tar.gz )"

RESTRICT="strip binchecks"

LANGS="de es fa fr ja pl pt_BR ro tr"
for lang in ${LANGS} ; do
	IUSE="${IUSE} linguas_${lang}"
	SRC_URI="${SRC_URI}
		linguas_${lang}? ( http://www.php.net/distributions/manual/${MY_PN}_${lang}.tar.gz )"
done

S=${WORKDIR}

src_unpack() {
	for lang in en ${LANGS} ; do
		if use linguas_${lang} ; then
			mkdir ${lang}
			pushd ${lang} >/dev/null
			unpack ${MY_PN}_${lang}.tar.gz || die "unpack failed on ${lang}"
			popd >/dev/null
		fi
	done
}

pkg_preinst() {
	# remove broken/stale symlink created by previous ebuilds
	[[ -L ${EROOT}/usr/share/php-docs ]] && rm -f "${EROOT}"/usr/share/php-docs
}

src_install() {
	dodir /usr/share/doc/${PF}

	for lang in en ${LANGS} ; do
		if use linguas_${lang} ; then
			ebegin "Installing ${lang} manual, will take a while"
			cp -R "${WORKDIR}"/${lang} "${ED}"/usr/share/doc/${PF} || die "cp failed on ${lang}"
			eend $?
		fi
	done

	einfo "Creating symlink to PHP manual at /usr/share/php-docs"
	dosym /usr/share/doc/${PF} /usr/share/php-docs
}
