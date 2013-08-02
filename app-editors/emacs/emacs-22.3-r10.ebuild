# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-22.3-r10.ebuild,v 1.8 2013/08/02 16:14:53 ulm Exp $

EAPI=5
WANT_AUTOMAKE="none"

inherit autotools elisp-common eutils flag-o-matic

DESCRIPTION="The extensible, customizable, self-documenting real-time display editor"
HOMEPAGE="http://www.gnu.org/software/emacs/"
SRC_URI="mirror://gnu/emacs/${P}.tar.gz
	mirror://gentoo/${P}-patches-8.tar.bz2"

LICENSE="GPL-3+ FDL-1.2+ BSD HPND MIT"
SLOT="22"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="alsa games gif gtk gzip-el hesiod jpeg kerberos motif png sound source tiff toolkit-scroll-bars X Xaw3d +xpm"

RDEPEND="sys-libs/ncurses
	>=app-admin/eselect-emacs-1.2
	>=app-emacs/emacs-common-gentoo-1.3-r3[games?,X?]
	net-libs/liblockfile
	hesiod? ( net-dns/hesiod )
	kerberos? ( virtual/krb5 )
	alsa? ( media-libs/alsa-lib )
	X? (
		x11-libs/libXmu
		x11-libs/libXt
		x11-misc/xbitmaps
		gif? ( media-libs/giflib )
		jpeg? ( virtual/jpeg:0= )
		png? ( >=media-libs/libpng-1.4:0= )
		tiff? ( media-libs/tiff )
		xpm? ( x11-libs/libXpm )
		gtk? ( x11-libs/gtk+:2 )
		!gtk? (
			Xaw3d? ( x11-libs/libXaw3d )
			!Xaw3d? ( motif? ( >=x11-libs/motif-2.3:0 ) )
		)
	)"

DEPEND="${RDEPEND}
	alsa? ( virtual/pkgconfig )
	X? ( gtk? ( virtual/pkgconfig ) )
	gzip-el? ( app-arch/gzip )"

# FULL_VERSION keeps the full version number, which is needed in order to
# determine some path information correctly for copy/move operations later on
FULL_VERSION="${PV}"
EMACS_SUFFIX="emacs-${SLOT}"
SITEFILE="20${PN}-${SLOT}-gentoo.el"

src_prepare() {
	EPATCH_SUFFIX=patch epatch

	sed -i \
		-e "s:/usr/lib/crtbegin.o:$(`tc-getCC` -print-file-name=crtbegin.o):g" \
		-e "s:/usr/lib/crtend.o:$(`tc-getCC` -print-file-name=crtend.o):g" \
		"${S}"/src/s/freebsd.h || die "unable to sed freebsd.h settings"

	if ! use alsa; then
		# ALSA is detected even if not requested by its USE flag.
		# Suppress it by supplying pkg-config with a wrong library name.
		sed -i -e "/ALSA_MODULES=/s/alsa/DiSaBlEaLsA/" configure.in \
			|| die "unable to sed configure.in"
	fi
	if ! use gzip-el; then
		# Emacs' build system automatically detects the gzip binary and
		# compresses el files. We don't want that so confuse it with a
		# wrong binary name
		sed -i -e "s/ gzip/ PrEvEnTcOmPrEsSiOn/" configure.in \
			|| die "unable to sed configure.in"
	fi

	eautoreconf
}

src_configure() {
	strip-flags
	filter-flags -fstack-protector -fstack-protector-all	#285778
	replace-flags "-O[3-9]" -O2
	sed -i -e "s/-lungif/-lgif/g" configure* src/Makefile* || die

	local myconf

	if use alsa && ! use sound; then
		einfo "Although sound USE flag is disabled you chose to have alsa,"
		einfo "so sound is switched on anyway."
		myconf="${myconf} --with-sound"
	else
		myconf="${myconf} $(use_with sound)"
	fi

	if use X; then
		myconf="${myconf} --with-x"
		myconf="${myconf} $(use_with toolkit-scroll-bars)"
		myconf="${myconf} $(use_with gif) $(use_with jpeg)"
		myconf="${myconf} $(use_with png) $(use_with tiff)"
		myconf="${myconf} $(use_with xpm)"

		# GTK+ is the default toolkit if USE=gtk is chosen with other
		# possibilities. Emacs upstream thinks this should be standard
		# policy on all distributions
		if use gtk; then
			einfo "Configuring to build with GIMP Toolkit (GTK+)"
			myconf="${myconf} --with-x-toolkit=gtk"
		elif use Xaw3d; then
			einfo "Configuring to build with Xaw3d (Athena/Lucid) toolkit"
			myconf="${myconf} --with-x-toolkit=athena"
			myconf="${myconf} --without-gtk"
		elif use motif; then
			einfo "Configuring to build with Motif toolkit"
			myconf="${myconf} --with-x-toolkit=motif"
			myconf="${myconf} --without-gtk"
		else
			einfo "Configuring to build with no toolkit"
			myconf="${myconf} --with-x-toolkit=no"
			myconf="${myconf} --without-gtk"
		fi

		local f tk=
		for f in gtk Xaw3d motif; do
			use ${f} || continue
			[ "${tk}" ] \
				&& ewarn "USE flag \"${f}\" ignored (superseded by \"${tk}\")"
			tk="${tk}${tk:+ }${f}"
		done
	else
		myconf="${myconf} --without-x"
	fi

	econf \
		--program-suffix=-${EMACS_SUFFIX} \
		--infodir=/usr/share/info/${EMACS_SUFFIX} \
		--enable-locallisppath="/etc/emacs:${SITELISP}" \
		--without-carbon \
		--with-gameuser="${GAMES_USER_DED:-games}" \
		$(use_with hesiod) \
		$(use_with kerberos) $(use_with kerberos kerberos5) \
		${myconf}
}

src_compile() {
	export SANDBOX_ON=0			# for the unbelievers, see Bug #131505
	emake CC="$(tc-getCC)"
}

src_install () {
	emake DESTDIR="${D}" install

	rm "${D}"/usr/bin/emacs-${FULL_VERSION}-${EMACS_SUFFIX} \
		|| die "removing duplicate emacs executable failed"
	mv "${D}"/usr/bin/emacs-${EMACS_SUFFIX} "${D}"/usr/bin/${EMACS_SUFFIX} \
		|| die "moving Emacs executable failed"

	# move man pages to the correct place
	local m
	for m in "${D}"/usr/share/man/man1/* ; do
		mv "${m}" "${m%.1}-${EMACS_SUFFIX}.1" || die "mv man failed"
	done

	# move info dir to avoid collisions with the dir file generated by portage
	mv "${D}"/usr/share/info/${EMACS_SUFFIX}/dir{,.orig} \
		|| die "moving info dir failed"
	touch "${D}"/usr/share/info/${EMACS_SUFFIX}/.keepinfodir
	docompress -x /usr/share/info/${EMACS_SUFFIX}/dir.orig

	# avoid collision between slots, see bug #169033 e.g.
	rm "${D}"/usr/share/emacs/site-lisp/subdirs.el
	rm -rf "${D}"/var

	# remove unused <version>/site-lisp dir
	rm -rf "${D}"/usr/share/emacs/${FULL_VERSION}/site-lisp

	local c=";;"
	if use source; then
		insinto /usr/share/emacs/${FULL_VERSION}/src
		# This is not meant to install all the source -- just the
		# C source you might find via find-function
		doins src/*.[ch]
		c=""
	fi

	sed 's/^X//' >"${T}/${SITEFILE}" <<-EOF
	X
	;;; ${PN}-${SLOT} site-lisp configuration
	X
	(when (string-match "\\\\\`${FULL_VERSION//./\\\\.}\\\\>" emacs-version)
	X  ${c}(setq find-function-C-source-directory
	X  ${c}      "/usr/share/emacs/${FULL_VERSION}/src")
	X  (let ((path (getenv "INFOPATH"))
	X	(dir "/usr/share/info/${EMACS_SUFFIX}")
	X	(re "\\\\\`/usr/share/info\\\\>"))
	X    (and path
	X	 ;; move Emacs Info dir before anything else in /usr/share/info
	X	 (let* ((p (cons nil (split-string path ":" t))) (q p))
	X	   (while (and (cdr q) (not (string-match re (cadr q))))
	X	     (setq q (cdr q)))
	X	   (setcdr q (cons dir (delete dir (cdr q))))
	X	   (setq Info-directory-list (prune-directory-list (cdr p)))))))
	EOF
	elisp-site-file-install "${T}/${SITEFILE}" || die

	dodoc AUTHORS BUGS CONTRIBUTE README
}

pkg_preinst() {
	# move Info dir file to correct name
	local infodir=/usr/share/info/${EMACS_SUFFIX} f
	if [ -f "${D}"${infodir}/dir.orig ]; then
		mv "${D}"${infodir}/dir{.orig,} || die "moving info dir failed"
	elif [[ -d "${D}"${infodir} ]]; then
		# this should not happen in EAPI 4
		ewarn "Regenerating Info directory index in ${infodir} ..."
		rm -f "${D}"${infodir}/dir{,.*}
		for f in "${D}"${infodir}/*; do
			if [[ ${f##*/} != *-[0-9]* && -e ${f} ]]; then
				install-info --info-dir="${D}"${infodir} "${f}" \
					|| die "install-info failed"
			fi
		done
	fi
}

pkg_postinst() {
	elisp-site-regen
	eselect emacs update ifunset

	if use X; then
		elog "You need to install some fonts for Emacs."
		elog "Installing media-fonts/font-adobe-{75,100}dpi on the X server's"
		elog "machine would satisfy basic Emacs requirements under X11."
		elog
	fi

	elog "You can set the version to be started by /usr/bin/emacs through"
	elog "the Emacs eselect module, which also redirects man and info pages."
	elog "Therefore, several Emacs versions can be installed at the same time."
	elog "\"man emacs.eselect\" for details."
}

pkg_postrm() {
	elisp-site-regen
	eselect emacs update ifunset
}
