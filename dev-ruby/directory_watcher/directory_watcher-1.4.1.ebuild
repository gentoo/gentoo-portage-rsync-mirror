# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/directory_watcher/directory_watcher-1.4.1.ebuild,v 1.2 2014/04/24 17:39:29 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Monitors directories for changes"
HOMEPAGE="http://gemcutter.org/gems/directory_watcher https://github.com/TwP/directory_watcher/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
