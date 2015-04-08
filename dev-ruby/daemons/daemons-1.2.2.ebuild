# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/daemons/daemons-1.2.2.ebuild,v 1.1 2015/03/19 19:56:48 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_EXTRADOC="Releases README.md"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Wrap existing ruby scripts to be run as a daemon"
HOMEPAGE="https://github.com/thuehlinger/daemons"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="examples"

all_ruby_install() {
	all_fakegem_install

	use examples || return

	insinto /usr/share/doc/${PF}/
	doins -r examples
}
