# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/notmuch/notmuch-0.15.2.ebuild,v 1.4 2013/09/06 13:06:27 aidecoe Exp $

EAPI=4

PYTHON_DEPEND="python? 2:2.6 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.1"

inherit elisp-common eutils pax-utils distutils

DESCRIPTION="Thread-based e-mail indexer, supporting quick search and tagging"
HOMEPAGE="http://notmuchmail.org/"
SRC_URI="${HOMEPAGE%/}/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
REQUIRED_USE="
	pick? ( emacs )
	test? ( crypt emacs python )
	"
IUSE="bash-completion crypt debug doc emacs mutt nmbug pick python test vim
	zsh-completion"

CDEPEND="
	>=dev-libs/glib-2.22
	>=dev-libs/gmime-2.6.7
	<dev-libs/xapian-1.3
	sys-libs/talloc
	debug? ( dev-util/valgrind )
	emacs? ( >=virtual/emacs-23 )
	x86? ( >=dev-libs/xapian-1.2.7-r2 )
	vim? ( || ( >=app-editors/vim-7.0 >=app-editors/gvim-7.0 ) )
	"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( python? ( dev-python/sphinx ) )
	test? ( app-misc/dtach || ( >=app-editors/emacs-23[libxml2]
		>=app-editors/emacs-vcs-23[libxml2] ) sys-devel/gdb )
	"
RDEPEND="${CDEPEND}
	crypt? ( app-crypt/gnupg )
	nmbug? ( dev-vcs/git virtual/perl-File-Temp virtual/perl-PodParser )
	mutt? ( dev-perl/File-Which dev-perl/Mail-Box dev-perl/MailTools
		dev-perl/String-ShellQuote dev-perl/Term-ReadLine-Gnu
		virtual/perl-Digest-SHA virtual/perl-File-Path virtual/perl-Getopt-Long
		virtual/perl-PodParser
		)
	zsh-completion? ( app-shells/zsh )
	"

PATCHES=( )
DOCS=( AUTHORS NEWS README )
SITEFILE="50${PN}-gentoo.el"
SITEFILE_PICK="60${PN}-pick-gentoo.el"
MY_LD_LIBRARY_PATH="${WORKDIR}/${P}/lib"

bindings() {
	if use $1; then
		pushd bindings/$1 || die
		shift
		$@
		popd || die
	fi
}

pkg_setup() {
	if use emacs; then
		elisp-need-emacs 23 || die "Emacs version too low"
	fi
	use python && python_pkg_setup
}

src_prepare() {
	local p
	for p in "${PATCHES[@]}"; do
		epatch "${p}"
	done

	default
	bindings python distutils_src_prepare

	if use mutt; then
		mv contrib/notmuch-mutt/README contrib/notmuch-mutt/README-mutt || die
	fi

	if use pick; then
		mv contrib/notmuch-pick/README contrib/notmuch-pick/README-pick || die
	fi
}

src_configure() {
	local myeconfargs=(
		--bashcompletiondir="${ROOT}/usr/share/bash-completion"
		--emacslispdir="${ROOT}/${SITELISP}/${PN}"
		--emacsetcdir="${ROOT}/${SITEETC}/${PN}"
		--with-gmime-version=2.6
		--zshcompletiondir="${ROOT}/usr/share/zsh/site-functions"
		$(use_with bash-completion)
		$(use_with emacs)
		$(use_with zsh-completion)
	)
	econf "${myeconfargs[@]}"
}

src_compile() {
	default
	bindings python distutils_src_compile

	if use mutt; then
		pushd contrib/notmuch-mutt || die
		emake notmuch-mutt.1
		popd || die
	fi

	if use doc; then
		pydocs() {
			mv README README-python || die
			pushd docs || die
			emake html
			mv html ../python || die
			popd || die
		}
		LD_LIBRARY_PATH="${MY_LD_LIBRARY_PATH}" bindings python pydocs
	fi
}

src_test() {
	pax-mark -m notmuch
	LD_LIBRARY_PATH="${MY_LD_LIBRARY_PATH}" default
	pax-mark -ze notmuch
}

src_install() {
	default

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

		if use pick; then
			pushd contrib/notmuch-pick || die
			elisp-install "${PN}" notmuch-pick.el || die
			dodoc README-pick
			popd || die
			elisp-site-file-install "${FILESDIR}/${SITEFILE_PICK}" || die
		fi
	fi

	if use nmbug; then
		dobin contrib/nmbug/nmbug
	fi

	if use mutt; then
		[[ -e /etc/mutt/notmuch-mutt.rc ]] && NOTMUCH_MUTT_RC_EXISTS=1
		pushd contrib/notmuch-mutt || die
		dobin notmuch-mutt
		doman notmuch-mutt.1
		insinto /etc/mutt
		doins notmuch-mutt.rc
		dodoc README-mutt
		popd || die
	fi

	if use vim; then
		insinto /usr/share/vim/vimfiles
		doins -r vim/plugin vim/syntax
	fi

	DOCS="" bindings python distutils_src_install

	if use doc; then
		bindings python dohtml -r python
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
	use python && distutils_pkg_postinst

	if use mutt && [[ ! ${NOTMUCH_MUTT_RC_EXISTS} ]]; then
		elog "To enable notmuch support in mutt, add the following line into"
		elog "your mutt config file, please:"
		elog ""
		elog "  source /etc/mutt/notmuch-mutt.rc"
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
	use python && distutils_pkg_postrm
}
