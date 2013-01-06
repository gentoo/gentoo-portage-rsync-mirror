# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/logitechmediaserver-bin/files/logitechmediaserver.logrotate.d,v 1.1 2012/04/12 05:56:02 lavajoe Exp $

/var/log/logitechmediaserver/scanner.log /var/log/logitechmediaserver/server.log /var/log/logitechmediaserver/perfmon.log {
	missingok
	notifempty
	copytruncate
	rotate 5
	size 100k
	su logitechmediaserver logitechmediaserver
}
