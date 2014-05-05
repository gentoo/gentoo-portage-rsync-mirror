# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-common-gentoo/emacs-common-gentoo-1.4-r1.ebuild,v 1.1 2014/05/05 07:03:21 ulm Exp $

EAPI=5

inherit elisp-common eutils fdo-mime gnome2-utils readme.gentoo user

DESCRIPTION="Common files needed by all GNU Emacs versions"
HOMEPAGE="http://wiki.gentoo.org/wiki/Project:Emacs"
SRC_URI="http://dev.gentoo.org/~ulm/emacs/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="games X"

PDEPEND="virtual/emacs"

pkg_setup() {
	if use games && [[ -z $(egetent passwd "${GAMES_USER_DED:-games}") ]]
	then
		enewgroup "${GAMES_GROUP:-games}" 35
		enewuser "${GAMES_USER_DED:-games}" 36 /bin/bash \
			"${GAMES_PREFIX:-/usr/games}" "${GAMES_GROUP:-games}"
	fi
}

src_install() {
	insinto "${SITELISP}"
	doins subdirs.el
	newins site-gentoo.el{,.orig}

	keepdir /etc/emacs
	insinto /etc/emacs
	doins site-start.el

	if use games; then
		keepdir /var/games/emacs
		fowners "${GAMES_USER_DED:-games}" /var/games/emacs
	fi

	if use X; then
		local i
		domenu emacs.desktop emacsclient.desktop || die

		pushd icons
		newicon sink.png emacs-sink.png || die
		newicon emacs_48.png emacs.png || die
		newicon emacs22_48.png emacs22.png || die
		for i in 16 24 32 48 128; do
			insinto /usr/share/icons/hicolor/${i}x${i}/apps
			newins emacs_${i}.png emacs.png
			[[ ${i} -ne 128 ]] && newins emacs22_${i}.png emacs22.png
		done
		insinto /usr/share/icons/hicolor/scalable/apps
		doins emacs.svg
		popd

		gnome2_icon_savelist
	fi

	DOC_CONTENTS="All site initialisation for Gentoo-installed packages is
		added to ${SITELISP}/site-gentoo.el. In order for this site
		initialisation to be loaded for all users automatically, a default
		site startup file /etc/emacs/site-start.el is installed. You are
		responsible for maintenance of this file.
		\n\nAlternatively, individual users can add the following command:
		\n\n(require 'site-gentoo)
		\n\nto their ~/.emacs initialisation files, or, for greater
		flexibility, users may load single package-specific initialisation
		files from the ${SITELISP}/site-gentoo.d/ directory."
	readme.gentoo_create_doc
}

site-start-modified-p() {
	case $(cksum <"${EROOT}${SITELISP}/site-start.el") in
		# checksums of auto-generated site-start.el files
		"2098727038 349") return 1 ;;	# elisp-common.eclass
		"3626264063 355") return 1 ;;	# emacs-common-gentoo-1.0 (cvs rev 1.1)
		"3738455534 394") return 1 ;;	# emacs-common-gentoo-1.0 (cvs rev 1.6)
		"4199862847 394") return 1 ;;	# emacs-common-gentoo-1.1
		"2547348044 394") return 1 ;;	# emacs-common-gentoo-1.2
		"2214952934 397") return 1 ;;	# emacs-common-gentoo-1.2-r1
		"3917799317 397") return 1 ;;	# emacs-common-gentoo-1.2-r2
		*) return 0 ;;
	esac
}

pkg_preinst() {
	# make sure that site-gentoo.el exists since site-start.el requires it
	if [[ ! -d ${EROOT}${SITELISP} ]]; then
		mv "${ED}${SITELISP}"/site-gentoo.el{.orig,} || die
	else
		elisp-site-regen
		rm "${ED}${SITELISP}/site-gentoo.el.orig" || die
		cp "${EROOT}${SITELISP}/site-gentoo.el" "${ED}${SITELISP}/" || die
	fi

	if use games; then
		local f
		for f in /var/games/emacs/{snake,tetris}-scores; do
			if [[ -e ${EROOT}${f} ]]; then
				cp "${EROOT}${f}" "${ED}${f}" || die
			elif [[ -e ${EROOT}/var/lib${f#/var} ]]; then
				# backwards compatibility
				cp "${EROOT}/var/lib${f#/var}" "${ED}${f}" || die
			fi
			touch "${ED}${f}" || die
			chown "${GAMES_USER_DED:-games}" "${ED}${f}" || die
		done
	fi

	if [[ -e ${EROOT}${SITELISP}/site-start.el ]]; then
		ewarn "The location of the site startup file for Emacs has changed to"
		ewarn "/etc/emacs/site-start.el."
		if site-start-modified-p; then
			eerror "Locally modified ${SITELISP}/site-start.el file found."
			eerror "If this file contains your own customisation, you should"
			eerror "move it to /etc/emacs/. In any case, you must remove the"
			eerror "file from the old location."
			die "Cannot continue unless ${SITELISP}/site-start.el is removed."
		else
			ewarn "Removing the old ${SITELISP}/site-start.el file."
			rm -f "${EROOT}${SITELISP}/site-start.el"
		fi
	fi
}

pkg_postinst() {
	if use X; then
		fdo-mime_desktop_database_update
		gnome2_icon_cache_update
	fi

	readme.gentoo_print_elog
}

pkg_postrm() {
	if use X; then
		fdo-mime_desktop_database_update
		gnome2_icon_cache_update
	fi
}
